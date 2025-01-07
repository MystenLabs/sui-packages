module 0x6edddca7e9d5c0d7308272a39b56ec2d1df9efd47d399b3ea3e9257addd480f1::RETARD {
    struct RETARD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<RETARD>, arg1: 0x2::coin::Coin<RETARD>) {
        0x2::coin::burn<RETARD>(arg0, arg1);
    }

    fun init(arg0: RETARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RETARD>(arg0, 9, b"RETARD", b"RETARD INU", b"i like to buy cryptocurrency because its the best thing when you buy some and it has a grow and i sell it and i can buy a lambo and find a wife and she will be called lucy because thats what my dog was called but really i just want to press the buttons and see my money go up and then press it again and it goes down but its ok because the dev said trust the process and hold and that is what i do because the dev is my favourite dev and he is based i dont know what based is but i sometimes like to build a base with my sofa using the cushions as walls and then my blanket as a nice roof and i sit in there and watch cartoons and i have another screen so i can watch the chart all day because if you want to be a good crypto trader you have to watch the chart and then if it goes red your meant to sell and if it is green your meant to buy thats what ive been doing anyway hope you like it here ive gone and made my own token now so have a buy and join my group and we can be friends.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/hCq3LST/retard.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RETARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RETARD>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<RETARD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<RETARD>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

