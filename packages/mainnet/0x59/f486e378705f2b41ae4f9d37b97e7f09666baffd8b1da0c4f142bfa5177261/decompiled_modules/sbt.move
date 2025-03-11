module 0x59f486e378705f2b41ae4f9d37b97e7f09666baffd8b1da0c4f142bfa5177261::sbt {
    struct SBT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image: 0x1::string::String,
        records: vector<0x1::string::String>,
    }

    struct Register has copy, drop {
        id: 0x2::object::ID,
        minted_by: address,
        name: 0x1::string::String,
    }

    public entry fun add_record(arg0: &mut SBT, arg1: 0x1::string::String) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.records, arg1);
    }

    public fun avatar(arg0: &SBT) : 0x1::string::String {
        arg0.image
    }

    public fun destroy(arg0: SBT) {
        let SBT {
            id      : v0,
            name    : _,
            image   : _,
            records : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    entry fun mint_sbt(arg0: &0x59f486e378705f2b41ae4f9d37b97e7f09666baffd8b1da0c4f142bfa5177261::versionControl::GlobalConfig, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0x59f486e378705f2b41ae4f9d37b97e7f09666baffd8b1da0c4f142bfa5177261::versionControl::assert_vaild_package_version(arg0);
        let v0 = 0x2::object::new(arg4);
        let v1 = Register{
            id        : 0x2::object::uid_to_inner(&v0),
            minted_by : 0x2::tx_context::sender(arg4),
            name      : arg1,
        };
        0x2::event::emit<Register>(v1);
        let v2 = SBT{
            id      : v0,
            name    : arg1,
            image   : arg3,
            records : arg2,
        };
        0x2::transfer::public_transfer<SBT>(v2, 0x2::tx_context::sender(arg4));
    }

    public fun name(arg0: &SBT) : 0x1::string::String {
        arg0.name
    }

    public fun records(arg0: &SBT) : vector<0x1::string::String> {
        arg0.records
    }

    public fun set_avatar(arg0: &mut SBT, arg1: 0x1::string::String) {
        arg0.image = arg1;
    }

    // decompiled from Move bytecode v6
}

