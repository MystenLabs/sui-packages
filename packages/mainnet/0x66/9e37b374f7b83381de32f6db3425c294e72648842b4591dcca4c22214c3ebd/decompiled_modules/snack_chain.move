module 0x669e37b374f7b83381de32f6db3425c294e72648842b4591dcca4c22214c3ebd::snack_chain {
    struct SnackCard has store, key {
        id: 0x2::object::UID,
        owner: 0x1::string::String,
        balance: u64,
    }

    struct VendingMachine has store, key {
        id: 0x2::object::UID,
        snacks: vector<Product>,
        balance: u64,
    }

    struct Product has store {
        code: u64,
        name: 0x1::string::String,
        price: u64,
        stock: u64,
    }

    public fun addFounds(arg0: u64, arg1: &mut SnackCard) {
        arg1.balance = arg1.balance + arg0;
    }

    public fun addProduct(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: &mut VendingMachine) {
        let v0 = Product{
            code  : 0x1::vector::length<Product>(&arg3.snacks) + 1,
            name  : arg0,
            price : arg1,
            stock : arg2,
        };
        0x1::vector::push_back<Product>(&mut arg3.snacks, v0);
    }

    public fun buyProduct(arg0: u64, arg1: &mut SnackCard, arg2: &mut VendingMachine) {
        assert!(productExists(arg0, &arg2.snacks), 13906834560890437633);
        let v0 = 0x1::vector::borrow_mut<Product>(&mut arg2.snacks, arg0 - 1);
        assert!(v0.stock == 0, 13906834578070437891);
        assert!(arg1.balance >= v0.price, 13906834582365536261);
        v0.stock = v0.stock - 1;
        arg1.balance = arg1.balance - v0.price;
    }

    public fun createCard(arg0: 0x1::string::String, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SnackCard{
            id      : 0x2::object::new(arg2),
            owner   : arg0,
            balance : arg1,
        };
        0x2::transfer::transfer<SnackCard>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun createMachine(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VendingMachine{
            id      : 0x2::object::new(arg0),
            snacks  : 0x1::vector::empty<Product>(),
            balance : 0,
        };
        0x2::transfer::transfer<VendingMachine>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun getProduct(arg0: u64, arg1: &VendingMachine) : &Product {
        assert!(productExists(arg0, &arg1.snacks), 13906834500760895489);
        0x1::vector::borrow<Product>(&arg1.snacks, arg0 - 1)
    }

    public fun getProducts(arg0: &VendingMachine) : &vector<Product> {
        &arg0.snacks
    }

    public fun productExists(arg0: u64, arg1: &vector<Product>) : bool {
        arg0 <= 0x1::vector::length<Product>(arg1) && arg0 > 0
    }

    // decompiled from Move bytecode v6
}

