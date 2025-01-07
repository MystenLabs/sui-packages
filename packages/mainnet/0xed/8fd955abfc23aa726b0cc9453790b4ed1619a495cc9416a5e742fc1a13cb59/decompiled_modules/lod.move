module 0xed8fd955abfc23aa726b0cc9453790b4ed1619a495cc9416a5e742fc1a13cb59::lod {
    struct LOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOD>(arg0, 9, b"LOD", b"7K LOD", b"he demographics broke down as follows: 48 percent male, 52 percent female, 16 percent under 18 years old, 25 percent age 18-45, 40 percent age 46-65, 19 percent age over 65.he demographics broke down as follows: 48 percent male, 52 percent female, 16 percent under 18 years old, 25 percent age 18-45, 40 percent age 46-65, 19 percent age over 65.he demographics broke down as follows: 48 percent male, 52 percent female, 16 percent under 18 years old, 25 percent age 18-45, 40 percent age 46-65, 19 percent age over 65.he demographics broke down as follows: 48 percent male, 52 percent female, 16 percent under 18 years old, 25 percent age 18-45, 40 percent age 46-65, 19 percent age over 65.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be-alpha.7k.fun/api/file-upload/258aa0386ee331aa8c472576f74977c7blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

