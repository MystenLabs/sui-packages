module 0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::bitmap {
    struct Bitmap has store, key {
        id: 0x2::object::UID,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : Bitmap {
        Bitmap{id: 0x2::object::new(arg0)}
    }

    fun bucket_exists(arg0: &Bitmap, arg1: u256) : bool {
        0x2::dynamic_field::exists_with_type<u256, u256>(&arg0.id, arg1)
    }

    public fun destroy(arg0: Bitmap) {
        let Bitmap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun get(arg0: &Bitmap, arg1: u256) : bool {
        let (v0, v1) = key_mask(arg1);
        if (!bucket_exists(arg0, v0)) {
            return false
        };
        *0x2::dynamic_field::borrow<u256, u256>(&arg0.id, v0) & v1 != 0
    }

    fun key_mask(arg0: u256) : (u256, u256) {
        (arg0 >> 8, 1 << ((arg0 & 255) as u8))
    }

    fun safe_register(arg0: &mut Bitmap, arg1: u256) {
        if (!bucket_exists(arg0, arg1)) {
            0x2::dynamic_field::add<u256, u256>(&mut arg0.id, arg1, 0);
        };
    }

    public fun set(arg0: &mut Bitmap, arg1: u256) {
        let (v0, v1) = key_mask(arg1);
        safe_register(arg0, v0);
        let v2 = 0x2::dynamic_field::borrow_mut<u256, u256>(&mut arg0.id, v0);
        *v2 = *v2 | v1;
    }

    public fun unset(arg0: &mut Bitmap, arg1: u256) {
        let (v0, v1) = key_mask(arg1);
        if (!bucket_exists(arg0, v0)) {
            return
        };
        let v2 = 0x2::dynamic_field::borrow_mut<u256, u256>(&mut arg0.id, v0);
        *v2 = *v2 & (v1 ^ 115792089237316195423570985008687907853269984665640564039457584007913129639935);
    }

    // decompiled from Move bytecode v6
}

