module 0x7e0580bb1e6acd56f4946df428d4dccfc094ea6a30ffad5e033ae57b87b2708a::tato {
    struct TATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TATO>(arg0, 9, b"TATO", b"Pawtato", b"The core token of the Pawtato ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://img.pawtato.app/tato/TATO.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TATO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TATO>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<TATO>>(0x2::coin::mint<TATO>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

