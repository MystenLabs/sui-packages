module 0x9ed93fef0ce27e7825a71844fe04925d1e011ac48573094c4dbff1c7a8ab67b3::suik {
    struct SUIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIK>(arg0, 6, b"SUIK", b"Sui King", x"54686973206973204b696e6720746f6b656e206f662053756920636861696e2e0a416e796f6e652077686f2077616e74732063616e206275792069742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/elephant_eeef814f55.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

