module 0x756e57308d5ce6a72a74936b7a6a2ba829a9b503687a74556575ee139b3095c1::FUN {
    struct FUN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FUN>, arg1: 0x2::coin::Coin<FUN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<FUN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FUN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FUN>>(0x2::coin::mint<FUN>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<FUN>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FUN>>(arg0);
    }

    fun init(arg0: FUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUN>(arg0, 9, b"FUN", b"FUN TEST", b"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ut leo vitae lacus consectetur dignissim. Phasellus at elementum quam. Proin pretium et leo a fermentum. Duis lobortis dignissim metus, at tempus nisi accumsan eu. Aliquam semper turpis ligula, id volutpat massa tincidunt eu. Cras scelerisque ipsum a convallis sollicitudin. Vivamus facilisis scelerisque nisi sit amet elementum. Curabitur eget lobortis quam, ut fringilla ex. Sed quis ante non justo eleifend condimentum. Sed efficitur diam lorem, sed hendrerit ipsum dapibus sed. Etiam mattis nibh eu augue fermentum, eu blandit elit vulputate. Praesent finibus enim quis nibh pellentesque scelerisque quis tempor augue. Aenean in rhoncus augue. Phasellus pellentesque lacinia libero, et condimentum ipsum luctus vitae.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bigmoods.com/cdn/shop/products/BM-0001-1385_2048x.jpg?v=1667729039")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

