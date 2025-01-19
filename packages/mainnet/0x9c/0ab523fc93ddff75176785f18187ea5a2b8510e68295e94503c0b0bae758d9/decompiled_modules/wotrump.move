module 0x9c0ab523fc93ddff75176785f18187ea5a2b8510e68295e94503c0b0bae758d9::wotrump {
    struct WOTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOTRUMP>(arg0, 6, b"WoTrump", b"WojakTrump", b"WELCOME TO WOJAK TRUMP, WHERE THE CLASSIC WOJAK STRUGGLE MEETS THE ENERGY OF \"MAKE AMERICA GREAT AGAIN! HERE, WOJAK EMBRACES HIS INNER TRUMP-NAVIGATING THE UPS AND DOWNS OF LIFE, CHASING DREAMS OF MOONSHOT GAINS, AND COPING WITH THE FEELS OF MODERN-D", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737313712960.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOTRUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOTRUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

