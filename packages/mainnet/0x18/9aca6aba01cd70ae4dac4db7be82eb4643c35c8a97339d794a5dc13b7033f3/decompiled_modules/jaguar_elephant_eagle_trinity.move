module 0x189aca6aba01cd70ae4dac4db7be82eb4643c35c8a97339d794a5dc13b7033f3::jaguar_elephant_eagle_trinity {
    struct JAGUAR_ELEPHANT_EAGLE_TRINITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAGUAR_ELEPHANT_EAGLE_TRINITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAGUAR_ELEPHANT_EAGLE_TRINITY>(arg0, 6, b"Jaguar Elephant Eagle Trinity", b"JEET", b"From 0 to 10 million!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media1.tenor.com/m/bFhbpVnyAbIAAAAC/mood-excited.gif")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JAGUAR_ELEPHANT_EAGLE_TRINITY>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAGUAR_ELEPHANT_EAGLE_TRINITY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAGUAR_ELEPHANT_EAGLE_TRINITY>>(v1);
    }

    // decompiled from Move bytecode v6
}

