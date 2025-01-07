module 0xd559e962d04e033aeeaf1f381eaeac03dda495f39862494fa118bca8f25bf4e5::fox {
    struct FOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOX>(arg0, 6, b"FOX", b"ForestFox", b"ForestFox (FOX) is an eco-friendly cryptocurrency inspired by the clever and charming fox. This project is dedicated to promoting forest conservation and sustainable forestry practices, with a portion of earnings supporting reforestation and habitat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730951298371.54")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

