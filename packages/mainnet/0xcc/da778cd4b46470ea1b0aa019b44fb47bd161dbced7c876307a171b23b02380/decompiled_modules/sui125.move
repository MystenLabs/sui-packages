module 0xccda778cd4b46470ea1b0aa019b44fb47bd161dbced7c876307a171b23b02380::sui125 {
    struct SUI125 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI125, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI125>(arg0, 6, b"SUI125", b"Suzuki Sui 125", b"In March 2023, Suzuki launched a new scooter model in Taiwan, the Sui 125, that's design is said to be inspired by the Japanese K-cars, the square and practical small cars that are popular in Japan. While the Saluto 125, also sold in Taiwan, offers modern technical solutions like keyless ignition, LED lightning and LCD instrument, the Sui has traditional analogue meters halogen bulbs, only the rear blinkers are LED. The brakes are front discs and rear drums, no CBS, or ABS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0295_777a5e5f81.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI125>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI125>>(v1);
    }

    // decompiled from Move bytecode v6
}

