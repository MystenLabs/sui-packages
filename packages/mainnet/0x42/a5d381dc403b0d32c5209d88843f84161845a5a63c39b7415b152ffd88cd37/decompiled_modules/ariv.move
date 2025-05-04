module 0x42a5d381dc403b0d32c5209d88843f84161845a5a63c39b7415b152ffd88cd37::ariv {
    struct ARIV has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARIV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARIV>(arg0, 2, b"Ariv", b"Ariv", b"Ariv Membership", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.dropbox.com/scl/fi/vgt7lq46t66a4ky1mzarh/arivM.png?rlkey=idz3943y56soxqd7q807d1jhg&st=s2rwnfbl&dl=0")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ARIV>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARIV>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARIV>>(v1);
    }

    // decompiled from Move bytecode v6
}

