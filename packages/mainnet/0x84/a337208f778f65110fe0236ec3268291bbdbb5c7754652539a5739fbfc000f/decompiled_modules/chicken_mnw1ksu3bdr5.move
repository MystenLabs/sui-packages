module 0x84a337208f778f65110fe0236ec3268291bbdbb5c7754652539a5739fbfc000f::chicken_mnw1ksu3bdr5 {
    struct CHICKEN_MNW1KSU3BDR5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHICKEN_MNW1KSU3BDR5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHICKEN_MNW1KSU3BDR5>(arg0, 9, b"CHICKEN", b"Rocket chicken", b"Beautiful", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmP3ZkFkjw6mup3tiz88EunNdCvyraDHm16W61fypNP25h")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHICKEN_MNW1KSU3BDR5>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHICKEN_MNW1KSU3BDR5>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

