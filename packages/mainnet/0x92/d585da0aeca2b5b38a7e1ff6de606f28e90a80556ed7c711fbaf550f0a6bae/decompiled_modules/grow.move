module 0x92d585da0aeca2b5b38a7e1ff6de606f28e90a80556ed7c711fbaf550f0a6bae::grow {
    struct MyPipisa has store, key {
        id: 0x2::object::UID,
        url: 0x2::url::Url,
        spent: u64,
    }

    public entry fun grow(arg0: &mut MyPipisa, arg1: 0x2::coin::Coin<0x92d585da0aeca2b5b38a7e1ff6de606f28e90a80556ed7c711fbaf550f0a6bae::pipisa::PIPISA>, arg2: &mut 0x92d585da0aeca2b5b38a7e1ff6de606f28e90a80556ed7c711fbaf550f0a6bae::pipisa::Holder, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.spent = arg0.spent + 0x2::coin::value<0x92d585da0aeca2b5b38a7e1ff6de606f28e90a80556ed7c711fbaf550f0a6bae::pipisa::PIPISA>(&arg1);
        if (arg0.spent > 300000000) {
            arg0.url = 0x2::url::new_unsafe_from_bytes(b"https://paper.kg/wp-content/uploads/2019/04/der.jpg");
        } else if (arg0.spent > 200000000) {
            arg0.url = 0x2::url::new_unsafe_from_bytes(b"https://sdiskontom.ru/upload/iblock/f44/32luy08gf5kwpw8mjftl59c720vpg20o.jpg");
        } else if (arg0.spent > 100000000) {
            arg0.url = 0x2::url::new_unsafe_from_bytes(b"https://sdiskontom.ru/upload/iblock/b12/lfd3qwd8zm6sgtmy6r6hr57x1vtsmjhb.jpg");
        };
        0x92d585da0aeca2b5b38a7e1ff6de606f28e90a80556ed7c711fbaf550f0a6bae::pipisa::burn(arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MyPipisa{
            id    : 0x2::object::new(arg0),
            url   : 0x2::url::new_unsafe_from_bytes(b"https://images.prom.ua/6006924190_w600_h600_6006924190.jpg"),
            spent : 0,
        };
        0x2::transfer::public_transfer<MyPipisa>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

