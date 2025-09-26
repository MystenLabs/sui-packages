module 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::wowok {
    struct Wowok has store, key {
        id: 0x2::object::UID,
        initor: address,
        entities: address,
    }

    public fun guard_query(arg0: &Wowok, arg1: &mut 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::Passport) {
        let v0 = 0x2::object::id_address<Wowok>(arg0);
        let (v1, v2, _) = 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::ON_PASSPORT(arg1, &v0);
        if (v2 == 900) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<address>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_ADDRESS(), &arg0.initor);
        } else if (v2 == 901) {
            0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::passport::BUILD_RESULT_DATA<address>(v1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::TYPE_STATIC_ADDRESS(), &arg0.entities);
        } else {
            0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::passport::Q_CMD_NOT_MATCH();
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Wowok{
            id       : 0x2::object::new(arg0),
            initor   : 0x2::tx_context::sender(arg0),
            entities : 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::entity::create(arg0),
        };
        0x2::transfer::share_object<Wowok>(v0);
    }

    public fun oracle_repository(arg0: &0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::wowok::ORACLE, arg1: 0x1::string::String, arg2: &0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::permission::Permission, arg3: &mut 0x2::tx_context::TxContext) : address {
        let v0 = 0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::repository::wowok(&arg1, 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::repository::TYPE_WOWOK_ORACLE(), 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::repository::POLICY_MODE_STRICT(), arg2, arg3);
        0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::repository::wowok_create(v0);
        0x2::object::id_address<0xb8e5c4de9c3e291e56f6293d26a062f95ab7fece9f5d1840ced3970735ec9636::repository::Repository>(&v0)
    }

    // decompiled from Move bytecode v6
}

