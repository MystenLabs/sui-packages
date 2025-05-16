module 0x5a78e44178ff8a33ca8b28425071895ba0107146948fda5996fffb9304d190fe::tuna {
    struct TUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUNA>(arg0, 9, b"TUNA", b"BIGTUNA", b"Yellowfin tuna is a species of tuna found in tropical waters. It's known for its vibrant yellow fins and meat rich in protein and omega-3 fatty acids. Often used in sashimi and sushi, it's a prized catch in commercial fisheries due to its flavor and nutritional value.  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/84a8a3422a4b527af96af6925ab2d81ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUNA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUNA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

