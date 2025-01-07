module 0x6fb75325074d6a14e17ed783f4acceb5dee0b960c4cd1636dc48eb5a8523bb8a::hss {
    struct HSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSS>(arg0, 9, b"HSS", b"chess", b"Smart and technical", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e33526b6-8edc-4c06-9797-10e4290c380f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

