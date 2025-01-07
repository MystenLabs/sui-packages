module 0x1807ec354b0d4766d853304a16a2f6162f14f08644f2818a710a7f34bcb5fbbd::waw {
    struct WAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAW>(arg0, 9, b"WAW", b"wawa", b"WAW token creat for wewe project ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ea5cb2be-08a6-46af-a27c-f93486149ee2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

