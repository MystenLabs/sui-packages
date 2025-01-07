module 0xa35d1339f400a66cbb1fcb3df748f6a5d0bb57b294b6a8fb85a2e318d5ceef01::lou {
    struct LOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOU>(arg0, 9, b"LOU", b"lou", b"lou is the cutest dog i have ever seen and he can bring a ton of joy to everyones life.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/5DQSDg6SGkbsbykq4mQstpcL4d5raEHc6rY7LgBwpump.png?size=xl&key=265604")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LOU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

