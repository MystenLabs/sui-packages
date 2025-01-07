module 0xd3ce9b7bf3fd8613fedf19065849566c39a756dd4b7e95ee3ff989ca6bf5a7de::suidae {
    struct SUIDAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDAE>(arg0, 6, b"SUIDAE", b"SuidaeOnSui", b"Suidae Coin is a cryptocurrency rooted in the strength and adaptability of the Suidae family. Like the resilient wild boars and cunning pigs that thrive in diverse", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000341_8f545057de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDAE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDAE>>(v1);
    }

    // decompiled from Move bytecode v6
}

