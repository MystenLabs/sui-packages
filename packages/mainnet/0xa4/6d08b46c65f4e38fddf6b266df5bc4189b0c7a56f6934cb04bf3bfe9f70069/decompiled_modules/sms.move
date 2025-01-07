module 0xa46d08b46c65f4e38fddf6b266df5bc4189b0c7a56f6934cb04bf3bfe9f70069::sms {
    struct SMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMS>(arg0, 6, b"SMS", b"SaturdayMorningSuitoons", b"I remember it like it was yesterday, Saturday mornings Big Bowl of Lucky charms just me and my favorite show! DO YOU REMEMBER? Things were simple back then. Here's a little SUIstalgia  for those who know! MAKE THIS DISGUSTINGLY Viral no socials all trust! are you in? #NORUGGANG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012316_a182ff3132.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

