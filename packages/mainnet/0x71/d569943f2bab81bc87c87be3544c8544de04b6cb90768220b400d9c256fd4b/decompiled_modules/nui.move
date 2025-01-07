module 0x71d569943f2bab81bc87c87be3544c8544de04b6cb90768220b400d9c256fd4b::nui {
    struct NUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUI>(arg0, 9, b"NUI", b"NeiroOnSui", b"Neiro the Dog is now on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/54507ea1-57ac-414c-8100-8989ebbc5543.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

