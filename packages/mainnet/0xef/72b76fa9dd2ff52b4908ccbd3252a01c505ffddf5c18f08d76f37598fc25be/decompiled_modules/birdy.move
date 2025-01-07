module 0xef72b76fa9dd2ff52b4908ccbd3252a01c505ffddf5c18f08d76f37598fc25be::birdy {
    struct BIRDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRDY>(arg0, 6, b"BIRDY", b"SUI BIRDY", b"BIRDY empowers users with blockchain, offering tokenized assets, NFTs,GameFi, and Charity All While Rescuing Dogs Globally!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Ph_Iqz8ak_AA_2_Ufv_ddc516956b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIRDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

