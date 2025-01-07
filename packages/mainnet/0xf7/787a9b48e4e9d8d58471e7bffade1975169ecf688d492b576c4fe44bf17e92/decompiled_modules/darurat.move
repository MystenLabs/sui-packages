module 0xf7787a9b48e4e9d8d58471e7bffade1975169ecf688d492b576c4fe44bf17e92::darurat {
    struct DARURAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DARURAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DARURAT>(arg0, 9, b"DARURAT", b"Voice call", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d3651491-8adf-446a-ad47-fb55512a7d2e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DARURAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DARURAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

