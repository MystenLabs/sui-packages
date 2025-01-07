module 0xa97bdd2e426c55a4033c5354490e7fafb7a910096613f324129178eb2d9653c9::shekz {
    struct SHEKZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEKZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEKZ>(arg0, 6, b"SHEKZ", b"Shekel Machine", x"4a6f75726e657920746f20612062696c6c696f6e20646f6c6c6172206275730a67657420726963686572207468616e2061206a6577200a6c6574732067657420746f207072696e74696e67207368656b656c73203a29", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734145435622.08")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHEKZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEKZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

