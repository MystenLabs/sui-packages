module 0x9c863cc129f7451fffc88fb8859745fbf0b67e4b808b9c157e94af783ee7c86e::doggo {
    struct DOGGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGGO>(arg0, 6, b"DOGGO", b"Doggo Argentino", b"\"Introducing Dogo Argentino ($DOGO) - The meme coin where utility is as mythical as a cat's loyalty!  Launched on the Sui Chain, $DOGO isn't here to solve world hunger or fetch your slippers; it's here to make you chuckle, scratch your head, and maybe howl at the moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000011353_15214ac12d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

