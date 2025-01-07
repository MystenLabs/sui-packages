module 0xe3a1c2a878cc8983b3486f51a38df701a3b9d10cc24490965808d12a9ba63851::tgk {
    struct TGK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGK>(arg0, 6, b"TGK", b"Tokyo Ghoul", b"Tokyo Ghoul is a Japanese dark fantasy manga series written and illustrated by Sui Ishida. It was serialized in Shueisha's seinen manga magazine Weekly Young Jump from September 2011 to September 2014, with its chapters collected in 14 tankbon volumes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ghoul_796bad5995.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TGK>>(v1);
    }

    // decompiled from Move bytecode v6
}

