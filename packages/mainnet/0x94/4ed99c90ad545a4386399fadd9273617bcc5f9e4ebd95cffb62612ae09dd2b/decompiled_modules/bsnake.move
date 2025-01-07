module 0x944ed99c90ad545a4386399fadd9273617bcc5f9e4ebd95cffb62612ae09dd2b::bsnake {
    struct BSNAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSNAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSNAKE>(arg0, 9, b"BSNAKE", b"BabySnake", b"BabySnake is a Fun MeMe Token on SUI Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/08415ae8-c51d-423a-8a98-cf0740f9a88d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSNAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSNAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

