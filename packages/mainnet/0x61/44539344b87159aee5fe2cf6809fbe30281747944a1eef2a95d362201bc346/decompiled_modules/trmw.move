module 0x6144539344b87159aee5fe2cf6809fbe30281747944a1eef2a95d362201bc346::trmw {
    struct TRMW has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRMW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRMW>(arg0, 9, b"TRMW", b"TRUMP WON", b"the winning giant", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/969fb52d-d2a5-4a20-8777-a5ad41237ee0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRMW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRMW>>(v1);
    }

    // decompiled from Move bytecode v6
}

