module 0xf2e6fc032f3eab5640e56ba9b5a8c8ddb032a0fa142a90dd793fb30d3cf35b18::gig {
    struct GIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIG>(arg0, 9, b"GIG", b"Gigcoin", x"476967636f696e206973206120646563656e7472616c697a65642063727970746f63757272656e637920666f7220667265656c616e6365727320616e642067696720776f726b6572732e20466173742c207365637572652c20616e6420656173792c20697420656d706f7765727320746865206769672065636f6e6f6d79207769746820696e7374616e74207061796d656e747320616e64206e6f206d6964646c656d656e2e20496e7665737420696e2074686520667574757265206f6620776f726b207769746820476967636f696e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5832519f-2f3e-4b8a-90a3-c0e0dc53448b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

