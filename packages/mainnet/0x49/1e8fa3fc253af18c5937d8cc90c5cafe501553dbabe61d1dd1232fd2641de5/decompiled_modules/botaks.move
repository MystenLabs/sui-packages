module 0x491e8fa3fc253af18c5937d8cc90c5cafe501553dbabe61d1dd1232fd2641de5::botaks {
    struct BOTAKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOTAKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOTAKS>(arg0, 9, b"BOTAKS", b"BOTAK JAYA", b"Botak gundul plontos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/71312174-ddd7-4193-b707-10fb4f62bbd3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOTAKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOTAKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

