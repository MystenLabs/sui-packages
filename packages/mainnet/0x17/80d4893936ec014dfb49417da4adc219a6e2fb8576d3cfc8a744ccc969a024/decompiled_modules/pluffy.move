module 0x1780d4893936ec014dfb49417da4adc219a6e2fb8576d3cfc8a744ccc969a024::pluffy {
    struct PLUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUFFY>(arg0, 6, b"PLUFFY", b"Sui Pluffy", b"PLUFFY -  fearless and fighting for free, fres grash, advocate for better pastures and bold opinions on politics & economics", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020692_e13dc033b7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUFFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUFFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

