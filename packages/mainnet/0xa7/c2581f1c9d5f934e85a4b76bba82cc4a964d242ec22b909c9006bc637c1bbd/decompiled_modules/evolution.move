module 0xa2f478f42e496b7bddb8d4dc6f5b42f1e85661ac010bd2bf807f02d45257c145::evolution {
    struct Treasury has key {
        id: 0x2::object::UID,
        status: bool,
    }

    struct VramNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        b36addr: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        number_id: u64,
    }

    public entry fun admin_update(arg0: &mut Treasury, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0x7f2f424e0b808b5ef40cd15bb682ca716c02fec2e5627aed836a55441ee27427 == 0x2::tx_context::sender(arg2), 0);
        arg0.status = arg1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id     : 0x2::object::new(arg0),
            status : true,
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    public entry fun vram_evolution(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: 0x2::object::ID, arg8: &mut Treasury, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg8.status == true, 0);
        0x2::kiosk::borrow_mut<VramNFT>(arg5, arg6, arg7);
    }

    // decompiled from Move bytecode v6
}

