module 0xf255d4b957aa707ea4c9792a0c99a4fcef98e0cca4313504571e49e4e16af02c::resume {
    struct ResumeManager has key {
        id: 0x2::object::UID,
        resumes: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct Resume has key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        date: 0x1::string::String,
        education: 0x1::string::String,
        mail: 0x1::string::String,
        number: 0x1::string::String,
        avatar: 0x1::string::String,
        abilities: vector<0x1::string::String>,
        experiences: vector<Experiences>,
        achievements: vector<Achievement>,
    }

    struct Experiences has drop, store {
        experience: 0x1::string::String,
        verification: bool,
    }

    struct Achievement has drop, store {
        achievement: 0x1::string::String,
        verification: bool,
    }

    struct ManagerCreated has copy, drop {
        resume_manager: 0x2::object::ID,
    }

    struct ResumeCreated has copy, drop {
        resume: 0x2::object::ID,
        user: address,
        name: 0x1::string::String,
        date: 0x1::string::String,
        education: 0x1::string::String,
        mail: 0x1::string::String,
        number: 0x1::string::String,
        avatar: 0x1::string::String,
    }

    struct AbilityAdded has copy, drop {
        resume: 0x2::object::ID,
        ability: 0x1::string::String,
    }

    struct ExperienceAdded has copy, drop {
        resume: 0x2::object::ID,
        experience: 0x1::string::String,
        verification: bool,
    }

    struct AchievementAdded has copy, drop {
        resume: 0x2::object::ID,
        achievement: 0x1::string::String,
        verification: bool,
    }

    public entry fun add_ability(arg0: &mut Resume, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.abilities, arg1);
        let v0 = AbilityAdded{
            resume  : 0x2::object::uid_to_inner(&arg0.id),
            ability : arg1,
        };
        0x2::event::emit<AbilityAdded>(v0);
    }

    public entry fun add_achievement(arg0: &mut Resume, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Achievement{
            achievement  : arg1,
            verification : false,
        };
        0x1::vector::push_back<Achievement>(&mut arg0.achievements, v0);
        let v1 = AchievementAdded{
            resume       : 0x2::object::uid_to_inner(&arg0.id),
            achievement  : arg1,
            verification : false,
        };
        0x2::event::emit<AchievementAdded>(v1);
    }

    public entry fun add_experience(arg0: &mut Resume, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Experiences{
            experience   : arg1,
            verification : false,
        };
        0x1::vector::push_back<Experiences>(&mut arg0.experiences, v0);
        let v1 = ExperienceAdded{
            resume       : 0x2::object::uid_to_inner(&arg0.id),
            experience   : arg1,
            verification : false,
        };
        0x2::event::emit<ExperienceAdded>(v1);
    }

    public entry fun create_resume(arg0: &mut ResumeManager, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::object::new(arg7);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = Resume{
            id           : v1,
            owner        : v0,
            name         : arg1,
            date         : arg2,
            education    : arg3,
            mail         : arg4,
            number       : arg5,
            avatar       : arg6,
            abilities    : 0x1::vector::empty<0x1::string::String>(),
            experiences  : 0x1::vector::empty<Experiences>(),
            achievements : 0x1::vector::empty<Achievement>(),
        };
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.resumes, v0, v2);
        let v4 = ResumeCreated{
            resume    : v2,
            user      : v0,
            name      : arg1,
            date      : arg2,
            education : arg3,
            mail      : arg4,
            number    : arg5,
            avatar    : arg6,
        };
        0x2::event::emit<ResumeCreated>(v4);
        0x2::transfer::transfer<Resume>(v3, v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = ResumeManager{
            id      : v0,
            resumes : 0x2::table::new<address, 0x2::object::ID>(arg0),
        };
        let v2 = ManagerCreated{resume_manager: 0x2::object::uid_to_inner(&v0)};
        0x2::event::emit<ManagerCreated>(v2);
        0x2::transfer::share_object<ResumeManager>(v1);
    }

    public entry fun revise_ability(arg0: &mut Resume, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        *0x1::vector::borrow_mut<0x1::string::String>(&mut arg0.abilities, arg2) = arg1;
    }

    public entry fun revise_achievement(arg0: &mut Resume, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Achievement{
            achievement  : arg1,
            verification : false,
        };
        *0x1::vector::borrow_mut<Achievement>(&mut arg0.achievements, arg2) = v0;
    }

    public entry fun revise_experience(arg0: &mut Resume, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Experiences{
            experience   : arg1,
            verification : false,
        };
        *0x1::vector::borrow_mut<Experiences>(&mut arg0.experiences, arg2) = v0;
    }

    // decompiled from Move bytecode v6
}

