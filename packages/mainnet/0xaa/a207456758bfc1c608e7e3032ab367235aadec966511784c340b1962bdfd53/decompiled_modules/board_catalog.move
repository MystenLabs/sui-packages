module 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::board_catalog {
    struct BoardCatalogKey has copy, drop, store {
        dummy_field: bool,
    }

    struct BoardCatalog has key {
        id: 0x2::object::UID,
        len: u64,
    }

    public fun add_board(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: &mut BoardCatalog, arg3: 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::combat_grid::GridSpec, arg4: &0x2::tx_context::TxContext) {
        0x2::dynamic_field::add<u64, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::combat_grid::GridSpec>(&mut arg2.id, arg2.len, arg3);
        arg2.len = arg2.len + 1;
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"fight_boards"), index_key(arg2.len - 1), arg4);
    }

    public fun create_catalog(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: &0x2::tx_context::TxContext) {
        let v0 = BoardCatalogKey{dummy_field: false};
        let v1 = BoardCatalog{
            id  : 0x2::derived_object::claim<BoardCatalogKey>(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::uid_mut(arg0, arg1, arg2), v0),
            len : 0,
        };
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"fight_boards"), 0x1::string::utf8(b"create"), arg2);
        0x2::transfer::share_object<BoardCatalog>(v1);
    }

    fun index_key(arg0: u64) : 0x1::string::String {
        0x1::u64::to_string(arg0)
    }

    public fun len(arg0: &BoardCatalog) : u64 {
        arg0.len
    }

    public fun pick(arg0: &BoardCatalog, arg1: u64) : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::combat_grid::GridSpec {
        assert!(arg0.len > 0, 4202);
        *0x2::dynamic_field::borrow<u64, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::combat_grid::GridSpec>(&arg0.id, arg1 % arg0.len)
    }

    public fun remove_last_board(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: &mut BoardCatalog, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2.len > 0, 4201);
        let v0 = arg2.len - 1;
        0x2::dynamic_field::remove<u64, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::combat_grid::GridSpec>(&mut arg2.id, v0);
        arg2.len = v0;
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"fight_boards"), index_key(v0), arg3);
    }

    public fun replace_board(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: &mut BoardCatalog, arg3: u64, arg4: 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::combat_grid::GridSpec, arg5: &0x2::tx_context::TxContext) {
        assert!(arg3 < arg2.len, 4201);
        *0x2::dynamic_field::borrow_mut<u64, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::combat_grid::GridSpec>(&mut arg2.id, arg3) = arg4;
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"fight_boards"), index_key(arg3), arg5);
    }

    // decompiled from Move bytecode v7
}

