module 0xaa017c8632633380780091d250fd93046af9ed0d7958d76e64be94e6a22f4f25::daramcto {
    struct DARAMCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DARAMCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DARAMCTO>(arg0, 6, b"DaramCTO", b"Daram", b"100% fair launch, no TG, no X.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003101_8b8b625ceb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DARAMCTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DARAMCTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

