module 0x58a2bd34645046e85076026de76d35aaf61a5f4fae1539bf70c7d080ef7d1d76::baso {
    struct BASO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BASO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BASO>(arg0, 6, b"BASO", b"BASO SUI", x"244241534f2c207468652077696c6465737420656e74697479206f6e20737569636861696e2e20427265616b696e6720626c6f636b732c2063617573696e67206368616f732c20616e6420726577726974696e67207468652072756c65732e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7895_825ec05e9d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BASO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BASO>>(v1);
    }

    // decompiled from Move bytecode v6
}

