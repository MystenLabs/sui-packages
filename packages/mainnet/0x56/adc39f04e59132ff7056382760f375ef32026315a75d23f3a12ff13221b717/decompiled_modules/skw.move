module 0x56adc39f04e59132ff7056382760f375ef32026315a75d23f3a12ff13221b717::skw {
    struct SKW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKW>(arg0, 6, b"SKW", b"SUI KAREN WHALE", b"this is a meme dedicated to the sui karen whale who stalked bookman ai token on movepump day and night. no socials no tg no team no insiders fully community driven in dedication to the investor that could not sleep, eat or think until she proved that bookman ai was a scam. Legend has it that sui karen whale is still very active on movepump seeking revenge for not receiving the answer she expected.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5f5cdddde6ff30001d4e87b6_3c4efd4d0d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKW>>(v1);
    }

    // decompiled from Move bytecode v6
}

