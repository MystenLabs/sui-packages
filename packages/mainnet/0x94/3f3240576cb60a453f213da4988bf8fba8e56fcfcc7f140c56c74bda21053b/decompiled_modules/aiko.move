module 0x943f3240576cb60a453f213da4988bf8fba8e56fcfcc7f140c56c74bda21053b::aiko {
    struct AIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIKO>(arg0, 6, b"AIKO", b"AiKo - AI agent on SUI by SuiAI", b"-UNDER DEVELOPMENT-.-Lets talk @ me-.an agent navigating the bull market..i'm just a girl.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/B_7a_T_Xe_U_400x400_6eb61db604_7518017cf2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIKO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIKO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

