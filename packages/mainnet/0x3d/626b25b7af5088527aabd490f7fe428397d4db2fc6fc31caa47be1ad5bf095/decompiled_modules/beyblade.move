module 0x3d626b25b7af5088527aabd490f7fe428397d4db2fc6fc31caa47be1ad5bf095::beyblade {
    struct BEYBLADE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEYBLADE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEYBLADE>(arg0, 6, b"BEYBLADE", b"BEYBLADE on SUI", b"Dragoon Victory Sting Evolution (, Doragn Bikutor Sutingu Eboryshon) is an Attack Type Beyblade released by Takara Tomy as part of the Burst System. It was released in Japan on December 26th, 2019 for 1100 as one of the prize Beyblades in Random Booster Vol. 18.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_07_at_9_31_45a_AM_48972ddb5b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEYBLADE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEYBLADE>>(v1);
    }

    // decompiled from Move bytecode v6
}

