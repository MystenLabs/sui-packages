module 0x7cff52c680699efff787f8c6f7a78fb71f06897ad2a875daaf3908545027c23b::god {
    struct GOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOD>(arg0, 6, b"GOD", b"God of Degeneracy", b"HELO FREN! I am BIG GREEN DILDO - God of Degenerac. Born from the ashes of failed pump-and-dump schemes and the hopes of overnight riches, $GOD is here to bless the faithful and punish the paper hands.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_16bb09b27b.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

