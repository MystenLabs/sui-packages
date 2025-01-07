module 0x44e059f0b38bf88dc3717909dae8ead599453123392503b9345e8c3961b6bd72::some_amm {
    struct DEVPASS has drop {
        dummy_field: bool,
    }

    entry fun swap() {
    }

    public fun dev_swap(arg0: 0x44e059f0b38bf88dc3717909dae8ead599453123392503b9345e8c3961b6bd72::dev_pass::SingleUse<DEVPASS>) : bool {
        let v0 = DEVPASS{dummy_field: false};
        0x44e059f0b38bf88dc3717909dae8ead599453123392503b9345e8c3961b6bd72::dev_pass::confirm_use<DEVPASS>(v0, arg0);
        true
    }

    public fun purchase_pass(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DEVPASS{dummy_field: false};
        let v1 = DEVPASS{dummy_field: false};
        0x44e059f0b38bf88dc3717909dae8ead599453123392503b9345e8c3961b6bd72::dev_pass::transfer<DEVPASS>(v0, 0x44e059f0b38bf88dc3717909dae8ead599453123392503b9345e8c3961b6bd72::dev_pass::issue_subscription<DEVPASS>(v1, 100, arg0), 0x2::tx_context::sender(arg0));
    }

    public fun topup_pass(arg0: &mut 0x44e059f0b38bf88dc3717909dae8ead599453123392503b9345e8c3961b6bd72::dev_pass::Subscription<DEVPASS>) {
        let v0 = DEVPASS{dummy_field: false};
        0x44e059f0b38bf88dc3717909dae8ead599453123392503b9345e8c3961b6bd72::dev_pass::add_uses<DEVPASS>(v0, arg0, 10);
    }

    // decompiled from Move bytecode v6
}

