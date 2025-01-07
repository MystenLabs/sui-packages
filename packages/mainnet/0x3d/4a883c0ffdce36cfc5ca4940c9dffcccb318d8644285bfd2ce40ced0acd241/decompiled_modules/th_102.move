module 0x3d4a883c0ffdce36cfc5ca4940c9dffcccb318d8644285bfd2ce40ced0acd241::th_102 {
    struct TH_102 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TH_102, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TH_102>(arg0, 9, b"TH_102", b"th102", b"thanghanh102.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/78e10edb-7a3f-4c8f-ba51-af673bc568b7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TH_102>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TH_102>>(v1);
    }

    // decompiled from Move bytecode v6
}

