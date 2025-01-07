module 0x72ee96eb1cbd84dd8c5776085ea20e59392d73d9a420bae3beea1e715fe7b4e2::hhughkjhkl {
    struct HHUGHKJHKL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHUGHKJHKL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHUGHKJHKL>(arg0, 9, b"HHUGHKJHKL", b"hjghjfkfh", b"hjgjkgkjg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2c9ff02c-02d2-4719-a977-5815331bc5fb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHUGHKJHKL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HHUGHKJHKL>>(v1);
    }

    // decompiled from Move bytecode v6
}

