module 0xc2806199aea27167db7124baaa128dd676046d28d8cb7641d951c2bdaee1b6e0::spkykits {
    struct SPKYKITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPKYKITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPKYKITS>(arg0, 6, b"SpkyKits", b"Spooky Kitties", b"Spooky Kitties is a NFT collection of 777 monsters", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Spky_Kits_f0184e0548.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPKYKITS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPKYKITS>>(v1);
    }

    // decompiled from Move bytecode v6
}

