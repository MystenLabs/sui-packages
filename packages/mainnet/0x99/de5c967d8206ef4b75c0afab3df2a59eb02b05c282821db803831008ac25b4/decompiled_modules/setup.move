module 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::setup {
    struct DeployerCap has store, key {
        id: 0x2::object::UID,
    }

    public fun complete(arg0: DeployerCap, arg1: 0x2::package::UpgradeCap, arg2: u16, arg3: vector<u8>, arg4: u32, arg5: vector<vector<u8>>, arg6: u32, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::package_utils::assert_package_upgrade_cap<DeployerCap>(&arg1, 0x2::package::compatible_policy(), 1);
        let DeployerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = 0x1::vector::empty<0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::guardian::Guardian>();
        let v2 = 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::cursor::new<vector<u8>>(arg5);
        while (!0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::cursor::is_empty<vector<u8>>(&v2)) {
            0x1::vector::push_back<0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::guardian::Guardian>(&mut v1, 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::guardian::new(0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::cursor::poke<vector<u8>>(&mut v2)));
        };
        0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::cursor::destroy_empty<vector<u8>>(v2);
        0x2::transfer::public_share_object<0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State>(0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::new(arg1, arg2, 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::external_address::new_nonzero(0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::bytes32::from_bytes(arg3)), arg4, v1, arg6, arg7, arg8));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DeployerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

