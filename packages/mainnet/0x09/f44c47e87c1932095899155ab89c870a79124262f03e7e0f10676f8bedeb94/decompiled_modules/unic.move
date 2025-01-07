module 0x9f44c47e87c1932095899155ab89c870a79124262f03e7e0f10676f8bedeb94::unic {
    struct UNIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNIC>(arg0, 6, b"UNIC", b"Uni Ceo", b"Hello Evan, we would like to inform you that you will be replaced by $UNICeo, who will take over as the new CEO of the @SuiNetwork  Be prepared for the upcoming surprises !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/uni_74b2fa118e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

