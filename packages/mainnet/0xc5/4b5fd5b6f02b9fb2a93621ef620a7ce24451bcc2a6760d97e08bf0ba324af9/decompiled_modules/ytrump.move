module 0xc54b5fd5b6f02b9fb2a93621ef620a7ce24451bcc2a6760d97e08bf0ba324af9::ytrump {
    struct YTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: YTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YTRUMP>(arg0, 6, b"YTRUMP", b"Yeah TRUMP!", b"fuck Trump yeah! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Donald_Trump_mad_meme_4_6434debae1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

