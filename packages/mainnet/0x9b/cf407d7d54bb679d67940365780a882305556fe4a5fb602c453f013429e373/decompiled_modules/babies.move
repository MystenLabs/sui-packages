module 0x9bcf407d7d54bb679d67940365780a882305556fe4a5fb602c453f013429e373::babies {
    struct BABIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABIES>(arg0, 6, b"BABIES", b"Babies 1st Rug", b"The name is obviously a joke, its literally 2 babies sitting on a rug but I just thought it would be funny to name it that but my 4yo wanted to get involved with creating a cool coin so its all in good fun! I will pay for Dex and Boosts as well! Join the telegram and X for updates, she loves watching those green candles with me!  Itd be awesome to tell them their coin got to the moon , literally! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250122_152945_890_9e2817ce4a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABIES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABIES>>(v1);
    }

    // decompiled from Move bytecode v6
}

