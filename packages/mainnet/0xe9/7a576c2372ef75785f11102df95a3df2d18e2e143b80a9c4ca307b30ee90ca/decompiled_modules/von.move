module 0xe97a576c2372ef75785f11102df95a3df2d18e2e143b80a9c4ca307b30ee90ca::von {
    struct VON has drop {
        dummy_field: bool,
    }

    fun init(arg0: VON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VON>(arg0, 6, b"VON", b"King Von", x"53746f70205069726174696e672e0a566f6e206973207761746368696e672e2e2e206576657279207472616e73616374696f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/m_Jm_byf_M_400x400_95a03bb7c6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VON>>(v1);
    }

    // decompiled from Move bytecode v6
}

