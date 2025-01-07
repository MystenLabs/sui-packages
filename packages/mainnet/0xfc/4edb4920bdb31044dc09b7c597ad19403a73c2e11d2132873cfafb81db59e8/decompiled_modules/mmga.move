module 0xfc4edb4920bdb31044dc09b7c597ad19403a73c2e11d2132873cfafb81db59e8::mmga {
    struct MMGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMGA>(arg0, 9, b"MMGA", b"Make Meme Great Again", b"Welcome to the enigmatic realm of MMGA, where the power of 'MEME' transcends the ordinary.  Telegram: https://t.me/MMGA_SUI  Twitter: https://x.com/MMGA_SUI  Website: https://mmgammga.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/mmgammga/mmga/refs/heads/main/mmga%20logo%20(1).png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MMGA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMGA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

