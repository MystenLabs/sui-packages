module 0x98d9e2f3a42d686f615aa4c214ea05d2e4d4860c9298ea6aee6285eddd7e14e0::HATDOG {
    struct HATDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HATDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HATDOG>(arg0, 6, b"Dapper Doge", b"HATDOG", b"A meme coin celebrating the ultra-stylish canine overlords who rule the internet with their impeccable hat game. Every HATDOG token is a tribute to the elegance and swagger of dogs in hats, uniting the crypto world with cuteness and flair. Join the pack and let's tip our hats to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafkreibzdykkr6q7owv3tjejdrpdkndsvt5iolzfmsxarcsoyozypv7qra")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HATDOG>>(v0, @0x2be6c850562754e11af55b7f049f4e304e488dff630b3832874d80c837c458a8);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HATDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

