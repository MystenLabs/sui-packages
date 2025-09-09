module 0x3ea4e8ab8ccf9b68df3941980e44463d072ccbabab7c48e660ae499fc0e7640b::Auth {
    struct AuthCap has store, key {
        id: 0x2::object::UID,
    }

    struct NonceHistory has store, key {
        id: 0x2::object::UID,
        nonce: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AuthCap{id: 0x2::object::new(arg0)};
        let v1 = NonceHistory{
            id    : 0x2::object::new(arg0),
            nonce : 0,
        };
        0x2::transfer::public_transfer<AuthCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_share_object<NonceHistory>(v1);
    }

    public fun permit(arg0: &AuthCap, arg1: &mut NonceHistory) {
        arg1.nonce = arg1.nonce + 1;
    }

    // decompiled from Move bytecode v6
}

