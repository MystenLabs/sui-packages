module 0xab98c7ee8ec92a70a5f25dcd744fe3be575e0c294176c3b04be5fc7d9066f58a::duckey {
    struct DUCKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKEY>(arg0, 6, b"DUCKEY", b"First Duckey  On Sui", b"HEY MAN, I'M DUCKEY! duckeycoin.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Jn_Rn_d_BT_400x400_f469cc19ca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

