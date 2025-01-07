module 0x73dbea229550ab310c478e4b5fad642792862f9fe0f704a2e2735bb702d392da::supply_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        dummy_field: bool,
    }

    public fun add<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    entry fun default<T0: store + key>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<T0>(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        add<T0>(v4, &v2);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<T0>>(v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<T0>>(v2, 0x2::tx_context::sender(arg1));
    }

    fun err_not_in_gachapon() {
        abort 0
    }

    public fun prove<T0, T1: store + key>(arg0: &mut 0x2::transfer_policy::TransferRequest<T1>, arg1: &0x73dbea229550ab310c478e4b5fad642792862f9fe0f704a2e2735bb702d392da::gachapon::Gachapon<T0>, arg2: &0x2::kiosk::Kiosk) {
        0x73dbea229550ab310c478e4b5fad642792862f9fe0f704a2e2735bb702d392da::gachapon::assert_valid_kiosk<T0>(arg1, arg2);
        if (!0x2::kiosk::has_item(arg2, 0x2::transfer_policy::item<T1>(arg0))) {
            err_not_in_gachapon();
        };
        let v0 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T1, Rule>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

