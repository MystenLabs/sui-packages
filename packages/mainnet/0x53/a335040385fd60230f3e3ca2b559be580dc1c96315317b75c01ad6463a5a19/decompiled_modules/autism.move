module 0x53a335040385fd60230f3e3ca2b559be580dc1c96315317b75c01ad6463a5a19::autism {
    struct AUTISM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUTISM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUTISM>(arg0, 9, b"AUTISM", b"AUTISM SUI", b"$AUTISM is a memecoin on Solana, where the focus is on having fun, vibing with the community, and participating in autistic-driven activities. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e9b53396-799e-405c-865f-0c8e828fa436.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUTISM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AUTISM>>(v1);
    }

    // decompiled from Move bytecode v6
}

