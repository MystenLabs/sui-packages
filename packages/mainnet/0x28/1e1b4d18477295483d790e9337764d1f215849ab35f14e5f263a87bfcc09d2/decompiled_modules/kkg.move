module 0x281e1b4d18477295483d790e9337764d1f215849ab35f14e5f263a87bfcc09d2::kkg {
    struct KKG has drop {
        dummy_field: bool,
    }

    fun init(arg0: KKG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KKG>(arg0, 9, b"KKG", b"Kingsfx", b"Football token gamepad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d47516a2-0435-499e-a36d-9fd49a73a9d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KKG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KKG>>(v1);
    }

    // decompiled from Move bytecode v6
}

