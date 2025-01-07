module 0x5cd4d66ed83182d3170c64aff5a2f6ff30173ccd934a3ea73b5ee633e222fc31::cosma {
    struct COSMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: COSMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COSMA>(arg0, 6, b"COSMA", b"Cosma SUI", x"20436f736d61436f696e207c20436f6d6d756e6974792d64726976656e2063727970746f2c20706f776572656420627920594f55212020436f736d696320616476656e74757265732061776169742077697468206f757220436f736d696320436f6d6963200a0a4a6f696e20436f736d6120617320736865206a6f75726e657973207468726f7567682074686520756e69766572736520616e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_zgsbdw_b1888aaa04.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COSMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COSMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

