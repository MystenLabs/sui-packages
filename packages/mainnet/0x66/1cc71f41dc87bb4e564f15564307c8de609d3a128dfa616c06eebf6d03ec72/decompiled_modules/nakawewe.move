module 0x661cc71f41dc87bb4e564f15564307c8de609d3a128dfa616c06eebf6d03ec72::nakawewe {
    struct NAKAWEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAKAWEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAKAWEWE>(arg0, 9, b"NAKAWEWE", b"WEWE", b"Suitoshi Nakawewe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/14cfaa25-f709-4661-97cf-854788e57ad2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAKAWEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAKAWEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

