module 0x616cea59b204b4f23f39bb3638745526b4d701cbeb415e2f50683a351fa2f601::a783956f993d811bc {
    struct A2f17e43c88bf6582 has store {
        ad3e49cf279957e7d: bool,
        a1c974970f8a64e97: bool,
        a70cd9a0f5ac83e39: u64,
    }

    struct A38f12468332ef716 has store {
        ad3e49cf279957e7d: bool,
        a1c974970f8a64e97: bool,
        a31889c32ae4ac722: u64,
        ad0b4b8410fc5a0f0: u64,
        aa5c536d0bc3827ff: u64,
        ae50da578c0f38435: u64,
        ac342a6a5cd6c420e: u64,
        ab0a69a408e88c1bf: u64,
        a2cd365a1174f0589: u64,
        a5d0574df4dc0d7ae: A2f17e43c88bf6582,
        a9a94df15e2e982c1: A2f17e43c88bf6582,
        ae54985ee5a6bd738: A2f17e43c88bf6582,
        a4fb516052eca6b29: A2f17e43c88bf6582,
        aa2649a904b16e7c0: A2f17e43c88bf6582,
        a104c5aad1828976e: A2f17e43c88bf6582,
    }

    struct A55929b390a61ff64 has store {
        aca879f29c55fc7f5: bool,
        a86a3ca1741b7ab76: u64,
        a36d6e89648c44eb7: u64,
        a0155665c45d45395: bool,
        a5cc224444e912e0d: bool,
        a4430b8d57adc5f0a: u64,
        a73a660ba084abb71: u64,
    }

    struct A0ea878587b719a64 has store, key {
        id: 0x2::object::UID,
        a1cf5727aac3dee05: address,
        adb133bf959620b1a: bool,
        a08c9d43f296691a1: u64,
        a028c32870d59a6e8: u64,
        ad66eeaefed209b0f: u64,
        aaa372af3148e91d6: u64,
        aa97ca27b48d72d63: u64,
        ab4cce892f91e179d: u64,
        a9eb34d40c591e724: u64,
        ab38de150e2840b48: u64,
        a7cea368357b7d971: bool,
        a7f1f6920b2de2e7c: bool,
        a31f95bf83694efb8: u64,
        a3a9b9d10c7fad14a: u64,
        a95922dffece9e7da: u64,
        ad4b2d799016f877d: u64,
        aa2dd106d27c96b47: u64,
        a25cd0a9a0177bf90: u64,
        a0c40826cc82d548a: u64,
        aabf49d2de82cae44: bool,
        af5b451c97d6b5192: u64,
        a82053465eda9bdc4: u64,
        ac342a6a5cd6c420e: u64,
        a2059360c1827f292: u64,
        aa8d95a01d0a32dc8: u64,
        ab3241576c7b31a2f: u64,
        a56fd38bb12b204a1: u64,
        ad2616e93a0796e5b: u64,
        a92e57031b4ab16ae: A38f12468332ef716,
        a24721a1521e81292: u64,
        a22a4acf8b8d612bd: A55929b390a61ff64,
    }

    public fun a028c32870d59a6e8(arg0: &A0ea878587b719a64) : u64 {
        arg0.a028c32870d59a6e8
    }

    public fun a02b2fbebbd0b1747(arg0: &A0ea878587b719a64) : bool {
        arg0.a22a4acf8b8d612bd.a5cc224444e912e0d
    }

    public fun a035758c2df2aac0a(arg0: &A0ea878587b719a64) : u64 {
        arg0.a22a4acf8b8d612bd.a4430b8d57adc5f0a
    }

    public fun a05a599e2994b5326(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a31f95bf83694efb8 = arg1;
    }

    public fun a061070a87240fe85(arg0: &mut A0ea878587b719a64, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.a4fb516052eca6b29.a1c974970f8a64e97 = arg1;
    }

    public fun a08c9d43f296691a1(arg0: &A0ea878587b719a64) : u64 {
        arg0.a08c9d43f296691a1
    }

    public fun a0b76acee4e57496d(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.aaa372af3148e91d6 = arg1;
    }

    public fun a0c40826cc82d548a(arg0: &A0ea878587b719a64) : u64 {
        arg0.a0c40826cc82d548a
    }

    public fun a0d51d893f042eb05(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.a2cd365a1174f0589 = arg1;
    }

    public fun a0ea1f46e048fbf21(arg0: &A0ea878587b719a64) : u64 {
        arg0.a92e57031b4ab16ae.a31889c32ae4ac722
    }

    public fun a0f9e212bfe700fad(arg0: &A0ea878587b719a64) : &A2f17e43c88bf6582 {
        &arg0.a92e57031b4ab16ae.ae54985ee5a6bd738
    }

    public fun a0ff07c53a8744191(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a08c9d43f296691a1 = arg1;
    }

    public fun a11395e18cbd0f417(arg0: &mut A0ea878587b719a64, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a22a4acf8b8d612bd.aca879f29c55fc7f5 = arg1;
    }

    public fun a1530e2bdfbfc62a8(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.ad4b2d799016f877d = arg1;
    }

    public fun a19b1796befec3f1c(arg0: &mut A0ea878587b719a64, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.aa2649a904b16e7c0.a1c974970f8a64e97 = arg1;
    }

    public fun a1c4aedba00214708(arg0: &A0ea878587b719a64) : &A2f17e43c88bf6582 {
        &arg0.a92e57031b4ab16ae.a104c5aad1828976e
    }

    public fun a1c974970f8a64e97(arg0: &A2f17e43c88bf6582) : bool {
        arg0.a1c974970f8a64e97
    }

    public fun a1d4036cdf86e784c(arg0: &A0ea878587b719a64, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.a1cf5727aac3dee05 == 0x2::tx_context::sender(arg1), 13906835321099649023);
    }

    public fun a2059360c1827f292(arg0: &A0ea878587b719a64) : u64 {
        arg0.a2059360c1827f292
    }

    public fun a218b36ceb9152448(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a3a9b9d10c7fad14a = arg1;
    }

    public fun a24721a1521e81292(arg0: &A0ea878587b719a64) : u64 {
        arg0.a24721a1521e81292
    }

    public fun a25cd0a9a0177bf90(arg0: &A0ea878587b719a64) : u64 {
        arg0.a25cd0a9a0177bf90
    }

    public fun a28c70aa22a06b7eb(arg0: &A0ea878587b719a64) : u64 {
        arg0.a22a4acf8b8d612bd.a86a3ca1741b7ab76
    }

    public fun a2a31b081c17fc9e6(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a22a4acf8b8d612bd.a4430b8d57adc5f0a = arg1;
    }

    public fun a2d2c317721113b86(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.ad0b4b8410fc5a0f0 = arg1;
    }

    public fun a2f38e257a3e855b0(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a22a4acf8b8d612bd.a73a660ba084abb71 = arg1;
    }

    public fun a31f95bf83694efb8(arg0: &A0ea878587b719a64) : u64 {
        arg0.a31f95bf83694efb8
    }

    public fun a3282aea81d2a5a5a(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a22a4acf8b8d612bd.a36d6e89648c44eb7 = arg1;
    }

    public fun a32961c499210d617(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.ab38de150e2840b48 = arg1;
    }

    public fun a34e369572ad2a090(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a95922dffece9e7da = arg1;
    }

    public fun a3710772f3b618373(arg0: &A0ea878587b719a64) : u64 {
        arg0.a92e57031b4ab16ae.ae50da578c0f38435
    }

    public fun a3a9b9d10c7fad14a(arg0: &A0ea878587b719a64) : u64 {
        arg0.a3a9b9d10c7fad14a
    }

    public fun a3c86152604cb8af7(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.a9a94df15e2e982c1.a70cd9a0f5ac83e39 = arg1;
    }

    public fun a3e97cb17cc8b4c07(arg0: &A0ea878587b719a64) : bool {
        arg0.a22a4acf8b8d612bd.aca879f29c55fc7f5
    }

    public fun a3ecf09b0d024e1dc(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.ad2616e93a0796e5b = arg1;
    }

    public fun a423a02d37ae4d2d0(arg0: &mut A0ea878587b719a64, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.a4fb516052eca6b29.ad3e49cf279957e7d = arg1;
    }

    public fun a442a391e32abfc25(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.ab4cce892f91e179d = arg1;
    }

    public fun a49db3fc04e55d0d1(arg0: &mut A0ea878587b719a64, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.a9a94df15e2e982c1.a1c974970f8a64e97 = arg1;
    }

    public fun a4c5eb3dce9c64948(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.ac342a6a5cd6c420e = arg1;
    }

    public fun a534253be9d7387c0(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.ad66eeaefed209b0f = arg1;
    }

    public fun a5431ba796ae3c794(arg0: &A0ea878587b719a64) : &A2f17e43c88bf6582 {
        &arg0.a92e57031b4ab16ae.aa2649a904b16e7c0
    }

    public fun a54b8c64e1ca3c1b5(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.a4fb516052eca6b29.a70cd9a0f5ac83e39 = arg1;
    }

    public fun a567749ca1bee95d3(arg0: &mut A0ea878587b719a64, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.a1c974970f8a64e97 = arg1;
    }

    public fun a56fd38bb12b204a1(arg0: &A0ea878587b719a64) : u64 {
        arg0.a56fd38bb12b204a1
    }

    public fun a58f3a8d8a4c01c05(arg0: &mut A0ea878587b719a64, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a7f1f6920b2de2e7c = arg1;
    }

    public fun a5ada7d72000d7a1d(arg0: &mut A0ea878587b719a64, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg5);
        arg0.a7cea368357b7d971 = arg3;
        arg0.a92e57031b4ab16ae.a1c974970f8a64e97 = arg3;
        if (!arg3) {
            let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1, &v0, arg4, arg5);
        };
    }

    public fun a60b885427f924b8d(arg0: &mut A0ea878587b719a64, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a22a4acf8b8d612bd.a5cc224444e912e0d = arg1;
    }

    public fun a611ed42baa1839e4(arg0: &A0ea878587b719a64) : bool {
        arg0.a22a4acf8b8d612bd.a0155665c45d45395
    }

    public fun a6219201efde0d46a(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a028c32870d59a6e8 = arg1;
    }

    public fun a633fa15402372c35(arg0: &A0ea878587b719a64) : bool {
        arg0.a92e57031b4ab16ae.ad3e49cf279957e7d
    }

    public fun a63fd163584228a06(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.aa8d95a01d0a32dc8 = arg1;
    }

    public fun a6608954bf63e2c55(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a24721a1521e81292 = arg1;
    }

    public fun a68b75565a7630638(arg0: &mut A0ea878587b719a64, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.a104c5aad1828976e.a1c974970f8a64e97 = arg1;
    }

    public fun a6b29e084f28cbe0e(arg0: &A0ea878587b719a64) : bool {
        arg0.a92e57031b4ab16ae.a1c974970f8a64e97
    }

    public fun a70cd9a0f5ac83e39(arg0: &A2f17e43c88bf6582) : u64 {
        arg0.a70cd9a0f5ac83e39
    }

    public fun a72f7a0d9af3aca6f(arg0: &mut A0ea878587b719a64, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.ae54985ee5a6bd738.ad3e49cf279957e7d = arg1;
    }

    public fun a764733b61c87862c(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.a104c5aad1828976e.a70cd9a0f5ac83e39 = arg1;
    }

    public fun a784c790c0b310a69(arg0: &A0ea878587b719a64) : u64 {
        arg0.a92e57031b4ab16ae.ad0b4b8410fc5a0f0
    }

    public fun a798314be18d9cf5d(arg0: &mut A0ea878587b719a64, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a22a4acf8b8d612bd.a0155665c45d45395 = arg1;
    }

    public fun a7cea368357b7d971(arg0: &A0ea878587b719a64) : bool {
        arg0.a7cea368357b7d971
    }

    public fun a7dffe34647363f88(arg0: &mut A0ea878587b719a64, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.a5d0574df4dc0d7ae.a1c974970f8a64e97 = arg1;
    }

    public fun a7e35067d3a47eeae(arg0: &A0ea878587b719a64) : u64 {
        arg0.a92e57031b4ab16ae.aa5c536d0bc3827ff
    }

    public fun a7f1f6920b2de2e7c(arg0: &A0ea878587b719a64) : bool {
        arg0.a7f1f6920b2de2e7c
    }

    public fun a82053465eda9bdc4(arg0: &A0ea878587b719a64) : u64 {
        arg0.a82053465eda9bdc4
    }

    public fun a8800b200e45dfdbd(arg0: &mut A0ea878587b719a64, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.adb133bf959620b1a = arg1;
    }

    public fun a8ca7876854a16d35(arg0: &mut 0x2::tx_context::TxContext) : A0ea878587b719a64 {
        let v0 = 1000000000;
        let v1 = A2f17e43c88bf6582{
            ad3e49cf279957e7d : true,
            a1c974970f8a64e97 : true,
            a70cd9a0f5ac83e39 : 1000,
        };
        let v2 = A2f17e43c88bf6582{
            ad3e49cf279957e7d : true,
            a1c974970f8a64e97 : true,
            a70cd9a0f5ac83e39 : 333,
        };
        let v3 = A2f17e43c88bf6582{
            ad3e49cf279957e7d : true,
            a1c974970f8a64e97 : true,
            a70cd9a0f5ac83e39 : 333,
        };
        let v4 = A2f17e43c88bf6582{
            ad3e49cf279957e7d : true,
            a1c974970f8a64e97 : true,
            a70cd9a0f5ac83e39 : 1000,
        };
        let v5 = A2f17e43c88bf6582{
            ad3e49cf279957e7d : true,
            a1c974970f8a64e97 : true,
            a70cd9a0f5ac83e39 : 1000,
        };
        let v6 = A2f17e43c88bf6582{
            ad3e49cf279957e7d : true,
            a1c974970f8a64e97 : true,
            a70cd9a0f5ac83e39 : 1000,
        };
        let v7 = A38f12468332ef716{
            ad3e49cf279957e7d : true,
            a1c974970f8a64e97 : true,
            a31889c32ae4ac722 : 500,
            ad0b4b8410fc5a0f0 : 500,
            aa5c536d0bc3827ff : 100 * 1000000000,
            ae50da578c0f38435 : 500 * 1000000000,
            ac342a6a5cd6c420e : 1,
            ab0a69a408e88c1bf : 200 * 1000000,
            a2cd365a1174f0589 : 200 * 1000000000,
            a5d0574df4dc0d7ae : v1,
            a9a94df15e2e982c1 : v2,
            ae54985ee5a6bd738 : v3,
            a4fb516052eca6b29 : v4,
            aa2649a904b16e7c0 : v5,
            a104c5aad1828976e : v6,
        };
        let v8 = A55929b390a61ff64{
            aca879f29c55fc7f5 : true,
            a86a3ca1741b7ab76 : 230000 * 1000000,
            a36d6e89648c44eb7 : 20000 * 1000000,
            a0155665c45d45395 : true,
            a5cc224444e912e0d : true,
            a4430b8d57adc5f0a : 90 * 1000000000,
            a73a660ba084abb71 : 100 * 1000000000,
        };
        A0ea878587b719a64{
            id                : 0x2::object::new(arg0),
            a1cf5727aac3dee05 : 0x2::tx_context::sender(arg0),
            adb133bf959620b1a : true,
            a08c9d43f296691a1 : 500,
            a028c32870d59a6e8 : 2000,
            ad66eeaefed209b0f : 8000,
            aaa372af3148e91d6 : 60000,
            aa97ca27b48d72d63 : 100 * v0,
            ab4cce892f91e179d : 500 * v0,
            a9eb34d40c591e724 : 20000 * v0,
            ab38de150e2840b48 : 20000 * v0,
            a7cea368357b7d971 : true,
            a7f1f6920b2de2e7c : true,
            a31f95bf83694efb8 : 2000,
            a3a9b9d10c7fad14a : 10000,
            a95922dffece9e7da : 5,
            ad4b2d799016f877d : v0,
            aa2dd106d27c96b47 : 200000 * 1000000,
            a25cd0a9a0177bf90 : 380 * v0,
            a0c40826cc82d548a : 500 * v0,
            aabf49d2de82cae44 : true,
            af5b451c97d6b5192 : 70 * 10000,
            a82053465eda9bdc4 : 390 * 10000,
            ac342a6a5cd6c420e : 1,
            a2059360c1827f292 : 500 * 1000000,
            aa8d95a01d0a32dc8 : 500 * v0,
            ab3241576c7b31a2f : 1000000000 / 4,
            a56fd38bb12b204a1 : 1000000000 / 2,
            ad2616e93a0796e5b : 10 * v0,
            a92e57031b4ab16ae : v7,
            a24721a1521e81292 : 500,
            a22a4acf8b8d612bd : v8,
        }
    }

    public fun a8f57f404176c397b(arg0: &A0ea878587b719a64) : u64 {
        arg0.a92e57031b4ab16ae.a2cd365a1174f0589
    }

    public fun a8fcd0b0e15997b35(arg0: &mut A0ea878587b719a64, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.a5d0574df4dc0d7ae.ad3e49cf279957e7d = arg1;
    }

    public fun a94b844b52efbcb50(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a22a4acf8b8d612bd.a86a3ca1741b7ab76 = arg1;
    }

    public fun a9556663ce914c54a(arg0: &A0ea878587b719a64) : &A2f17e43c88bf6582 {
        &arg0.a92e57031b4ab16ae.a9a94df15e2e982c1
    }

    public fun a95922dffece9e7da(arg0: &A0ea878587b719a64) : u64 {
        arg0.a95922dffece9e7da
    }

    public fun a9d6ab431aeba9963(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a0c40826cc82d548a = arg1;
    }

    public fun a9eb34d40c591e724(arg0: &A0ea878587b719a64) : u64 {
        arg0.a9eb34d40c591e724
    }

    public fun a9f8bdfd93f515fe0(arg0: &mut A0ea878587b719a64, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.aa2649a904b16e7c0.ad3e49cf279957e7d = arg1;
    }

    public fun aa2b7c8f205e1d355(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.ac342a6a5cd6c420e = arg1;
    }

    public fun aa2dd106d27c96b47(arg0: &A0ea878587b719a64) : u64 {
        arg0.aa2dd106d27c96b47
    }

    public fun aa324ade7b3d5401f(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a25cd0a9a0177bf90 = arg1;
    }

    public fun aa4c6cb5de6de44f7(arg0: &mut A0ea878587b719a64, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.aabf49d2de82cae44 = arg1;
    }

    public fun aa614ca3191892ed6(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a9eb34d40c591e724 = arg1;
    }

    public fun aa8d95a01d0a32dc8(arg0: &A0ea878587b719a64) : u64 {
        arg0.aa8d95a01d0a32dc8
    }

    public fun aa97ca27b48d72d63(arg0: &A0ea878587b719a64) : u64 {
        arg0.aa97ca27b48d72d63
    }

    public fun aaa372af3148e91d6(arg0: &A0ea878587b719a64) : u64 {
        arg0.aaa372af3148e91d6
    }

    public fun aabf49d2de82cae44(arg0: &A0ea878587b719a64) : bool {
        arg0.aabf49d2de82cae44
    }

    public fun aac907976125d91ba(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.aa2dd106d27c96b47 = arg1;
    }

    public fun aad446d582cfc333e(arg0: &mut A0ea878587b719a64, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.ad3e49cf279957e7d = arg1;
    }

    public fun aaf28676a30aaeb45(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.aa5c536d0bc3827ff = arg1;
    }

    public fun ab3241576c7b31a2f(arg0: &A0ea878587b719a64) : u64 {
        arg0.ab3241576c7b31a2f
    }

    public fun ab38de150e2840b48(arg0: &A0ea878587b719a64) : u64 {
        arg0.ab38de150e2840b48
    }

    public fun ab4cce892f91e179d(arg0: &A0ea878587b719a64) : u64 {
        arg0.ab4cce892f91e179d
    }

    public fun ab7f9bd571f575505(arg0: &A0ea878587b719a64) : u64 {
        arg0.a22a4acf8b8d612bd.a73a660ba084abb71
    }

    public fun aba503bef28f06bdf(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.a5d0574df4dc0d7ae.a70cd9a0f5ac83e39 = arg1;
    }

    public fun abc3ae4f61d07f772(arg0: &mut 0x2::tx_context::TxContext) : A0ea878587b719a64 {
        let v0 = a8ca7876854a16d35(arg0);
        v0.a25cd0a9a0177bf90 = 1 * 1000000000;
        v0.a0c40826cc82d548a = 0 * 1000000000;
        v0.a2059360c1827f292 = 5 * 1000000;
        v0.aa8d95a01d0a32dc8 = 5 * 1000000000;
        v0.aa97ca27b48d72d63 = 1 * 1000000000;
        v0.ab4cce892f91e179d = 1 * 1000000000;
        v0.a9eb34d40c591e724 = 1 * 1000000000;
        v0.ab38de150e2840b48 = 1 * 1000000000;
        v0.a92e57031b4ab16ae.aa5c536d0bc3827ff = 2 * 1000000000;
        v0.a92e57031b4ab16ae.ae50da578c0f38435 = 0 * 1000000000;
        v0.adb133bf959620b1a = true;
        v0.a7cea368357b7d971 = true;
        v0.a92e57031b4ab16ae.ad3e49cf279957e7d = true;
        v0.a92e57031b4ab16ae.a1c974970f8a64e97 = true;
        v0.a92e57031b4ab16ae.ab0a69a408e88c1bf = 2 * 1000000;
        v0.a92e57031b4ab16ae.a2cd365a1174f0589 = 2 * 1000000000;
        v0
    }

    public fun abf6c3390231a1e6c(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.ab0a69a408e88c1bf = arg1;
    }

    public fun ac1d2483d2a29057d(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.a31889c32ae4ac722 = arg1;
    }

    public fun ac342a6a5cd6c420e(arg0: &A0ea878587b719a64) : u64 {
        arg0.ac342a6a5cd6c420e
    }

    public fun ac6050178924956f0(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a56fd38bb12b204a1 = arg1;
    }

    public fun ac77367cbb5176919(arg0: &mut A0ea878587b719a64, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.a104c5aad1828976e.ad3e49cf279957e7d = arg1;
    }

    public fun ad0be49e9ae36ae12(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.ae50da578c0f38435 = arg1;
    }

    public fun ad2616e93a0796e5b(arg0: &A0ea878587b719a64) : u64 {
        arg0.ad2616e93a0796e5b
    }

    public fun ad3e49cf279957e7d(arg0: &A2f17e43c88bf6582) : bool {
        arg0.ad3e49cf279957e7d
    }

    public fun ad4985d21e71b208e(arg0: &A0ea878587b719a64) : u64 {
        arg0.a22a4acf8b8d612bd.a36d6e89648c44eb7
    }

    public fun ad4b2d799016f877d(arg0: &A0ea878587b719a64) : u64 {
        arg0.ad4b2d799016f877d
    }

    public fun ad66eeaefed209b0f(arg0: &A0ea878587b719a64) : u64 {
        arg0.ad66eeaefed209b0f
    }

    public fun ad7cdb88be6e05ea2(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.ae54985ee5a6bd738.a70cd9a0f5ac83e39 = arg1;
    }

    public fun adac8080ae87e9ba7(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.ab3241576c7b31a2f = arg1;
    }

    public fun adb133bf959620b1a(arg0: &A0ea878587b719a64) : bool {
        arg0.adb133bf959620b1a
    }

    public fun ae2894da560e9dfaf(arg0: &A0ea878587b719a64) : u64 {
        arg0.a92e57031b4ab16ae.ab0a69a408e88c1bf
    }

    public fun ae41484999624d684(arg0: &mut A0ea878587b719a64, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.ae54985ee5a6bd738.a1c974970f8a64e97 = arg1;
    }

    public fun ae5de1e3c5e9441d3(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.aa2649a904b16e7c0.a70cd9a0f5ac83e39 = arg1;
    }

    public fun ae63c22553f1e03a6(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a82053465eda9bdc4 = arg1;
    }

    public fun ae836d563d15dd6e6(arg0: &A0ea878587b719a64) : &A2f17e43c88bf6582 {
        &arg0.a92e57031b4ab16ae.a4fb516052eca6b29
    }

    public fun ae933eed2c225f8b5(arg0: &mut A0ea878587b719a64, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a92e57031b4ab16ae.a9a94df15e2e982c1.ad3e49cf279957e7d = arg1;
    }

    public fun ae939843e6bfc4243(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.a2059360c1827f292 = arg1;
    }

    public fun ae9a4ee60c1c9da40(arg0: &A0ea878587b719a64) : u64 {
        arg0.a92e57031b4ab16ae.ac342a6a5cd6c420e
    }

    public fun aede7ad9675ac505d(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.af5b451c97d6b5192 = arg1;
    }

    public fun aef0ef134c8dbb663(arg0: &A0ea878587b719a64) : &A2f17e43c88bf6582 {
        &arg0.a92e57031b4ab16ae.a5d0574df4dc0d7ae
    }

    public fun af5b451c97d6b5192(arg0: &A0ea878587b719a64) : u64 {
        arg0.af5b451c97d6b5192
    }

    public fun aff8e537b8d0b8029(arg0: &mut A0ea878587b719a64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg2);
        arg0.aa97ca27b48d72d63 = arg1;
    }

    // decompiled from Move bytecode v6
}

